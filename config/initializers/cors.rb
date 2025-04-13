Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3001'  # Your React frontend URL
      
      resource '*',
               headers: :any,
               methods: [:get, :post, :put, :patch, :delete, :options, :head]
  
      Rails.logger.debug "CORS configuration applied"
    end
  end
  