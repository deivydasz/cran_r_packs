class DailyPackageRetrieveWorker
  include Sidekiq::Worker

  def perform
    1
    #TODO: class to scan and spawn package download workers
  end
end