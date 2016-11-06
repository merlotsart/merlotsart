class ProjectRequest < ActiveRecord::Base

  RECTANGLE_CANVAS_SIZES = ["11\" x 14\"",
                            "16\" x 20\"",
                            "30\" x 40\"",
                            "Custom"]

  SQUARE_CANVAS_SIZES = [] # Presently unused but available for additional sizes

  SIZE_OPTIONS = { "Rectangle Sizes" => RECTANGLE_CANVAS_SIZES,
                   "Square Sizes" => SQUARE_CANVAS_SIZES }

  validates :name, :email, :size, presence: true
end
