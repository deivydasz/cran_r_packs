class DailyPackageRetrieveWorker
  include Sidekiq::Worker

  def perform
    url_to_read = 'https://cran.r-project.org/src/contrib/PACKAGES'
    read =  URI.open(url_to_read).each do |f|
      f.each_line do |line|
        if line.first(8) == "Package:"
          line.slice!("Package: ")
          package_name = line.chomp
        end
        if line.first(8) == "Version:"
          line.slice!("Version: ")
          version = line.chomp
        end
        process_name_version(package_name, version)
      end
    end
  end

  def process_name_version(package_name, version)
    #TODO create worker that downloads tar.gz and extracts information,
      #pass pairs one by one to enque backround jobs
  end

end
