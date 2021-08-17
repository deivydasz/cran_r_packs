require 'open-uri'
class DailyPackageRetrieveWorker
  include Sidekiq::Worker

  def perform(url_to_read)
    process_web_file(URI.open(url_to_read))
  end

  def process_web_file(file)
    package_name = nil
    file.each_line do |line|
      if line.first(8) == "Package:"
        line.slice!("Package: ")
        package_name = line.chomp
      elsif line.first(8) == "Version:" && package_name
        line.slice!("Version: ")
        version = line.chomp
        enque_file_worker(package_name, version)
        package_name = nil
      end
    end
  end

  def enque_file_worker(package_name, version)
    #TODO create worker that downloads tar.gz and extracts information,
      #pass pairs one by one to enque backround jobs
  end
end
