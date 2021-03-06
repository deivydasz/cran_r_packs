require 'open-uri'
require 'rubygems/package'
class SinglePackageRetrieveWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(package_name, version)
    return if Package.where(name: package_name, version: version).any?

    stream = URI.open(dowload_link(package_name, version))
    description = read_description_file(package_name, stream)
    extracted_information = required_info_hash(description)
    write_required_records(extracted_information)
  end

  private

  def dowload_link(package_name, version)
    "https://cran.r-project.org/src/contrib/#{package_name}_#{version}.tar.gz"
  end

  def read_description_file(package_name, stream)
    temp_file = make_tempfile(stream)
    compressed_file = Zlib::GzipReader.open(temp_file)
    uncompressed = Gem::Package::TarReader.new(compressed_file)
    uncompressed.detect do |f| 
      f.full_name == "#{package_name}/DESCRIPTION"
    end.read
  end

  def make_tempfile(stream)
    return stream if stream.respond_to?(:path)

    Tempfile.new.tap do |file|
      file.binmode
      IO.copy_stream(stream, file)
      stream.close
      file.rewind
    end
  end

  def required_info
    %w[Package Version Date/Publication Title Description Author Maintainer]
  end

  def required_info_hash(description)
    info_hash = {}
    required_info.map do |key|
      description.each_line do |line|
        if line.first(key.size + 1) == "#{key}:"
          line.slice!("#{key}: ")
          info_hash[key] = line.chomp
          break
        end
      end
    end
    info_hash
  end

  def write_required_records(extracted_information)
    package = write_package(extracted_information)
    write_author(extracted_information, package)
    write_maintainer(extracted_information, package)
  end

  def write_package(extracted_information)
    Package.create(
      name: extracted_information['Package'],
      version: extracted_information['Version'],
      publication_date: extracted_information['Date/Publication'],
      title: extracted_information['Title'],
      description: extracted_information['Description'],
    )
  end

  def write_author(extracted_information, package)
    author_name = extracted_information['Author'].split("<")[0].strip
    email = extracted_information['Author'][/(?<=<).*(?=>)/]
    package.authors.create(name: author_name, email: email)
  end

  def write_maintainer(extracted_information, package)
    maintainer_name = extracted_information['Maintainer'].split("<")[0].strip
    email = extracted_information['Maintainer'][/(?<=<).*(?=>)/]
    package.maintainers.create(name: maintainer_name, email: email)
  end
end
