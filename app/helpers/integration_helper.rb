module IntegrationHelper

  def categorize_data
    @data.group_by{ |item| item["type"] }.transform_values{ |items| items.map { |item| [item["name"], "#{item["id"]},#{item["type"]}"]}}
  end
end
