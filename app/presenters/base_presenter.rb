class BasePresenter

  def initialize(object:, view_template:)
    @object = object
    @view_template = view_template
  end


  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  private

  def h
    @view_template
  end
end