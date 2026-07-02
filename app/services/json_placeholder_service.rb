class JsonPlaceholderService
  BASE_URL = "https://jsonplaceholder.typicode.com"

  def initialize
    @connection = Faraday.new(url: BASE_URL) do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end

  def posts
    @connection.get("/posts").body.first(20)
  end

  def create_post(title:, body:)
    response = @connection.post("/posts", { title: title, body: body, userId: 1 })
    { status: response.status, body: response.body }
  end

  def update_post(id, title:, body:)
    @connection.patch("/posts/#{id}", { title: title, body: body })
  end

  def delete_post(id)
    @connection.delete("/posts/#{id}")
  end
end
