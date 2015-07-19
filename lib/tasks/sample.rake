namespace :sample do
  desc 'テスト'
  task test: :environment do |t|
    ap TaskLogger.info "hoge"
    #.replace(':', '_')
  end
end
