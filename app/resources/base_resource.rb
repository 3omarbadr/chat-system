class BaseResource
  def initialize(resource)
    @resource = resource
  end

  def as_json
    if @resource.respond_to?(:each)
      @resource.map { |item| serialize(item) }
    else
      serialize(@resource)
    end
  end

  private

  def serialize(resource)
    raise NotImplementedError, 'Subclasses must implement the serialize method'
  end
end
