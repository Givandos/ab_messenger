class CreateMessageTemplateService
  attr_reader :name, :text

  def initialize(name, text)
    @name = name
    @text = text
  end

  def perform
    MessageTemplate.create(name: name, text: text)
  end
end
