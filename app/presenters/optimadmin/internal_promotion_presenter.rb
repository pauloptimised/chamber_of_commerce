module Optimadmin
  class InternalPromotionPresenter < Optimadmin::BasePresenter
    presents :internal_promotion

    def name
      internal_promotion.name
    end

    def area
      internal_promotion.area
    end

  end
end
