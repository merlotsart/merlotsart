class ProjectRequest < ActiveRecord::Base

  RECTANGLE_CANVAS_SIZES = ["8\" x 10\"",
                            "9\" x 12\"",
                            "11\" x 14\"",
                            "12\" x 16\"",
                            "18\" x 24\"",
                            "20\" x 24\"",
                            "24\" x 36\"",
                            "30\" x 40\"",
                            "36\" x 48\"",
                            "40\" x 60\""]

  SQUARE_CANVAS_SIZES = [ "10\" x 10\"",
                          "12\" x 12\"",
                          "20\" x 20\"",
                          "30\" x 30\"",
                          "40\" x 40\""]

  SIZE_OPTIONS = { "Rectangle Sizes" => RECTANGLE_CANVAS_SIZES,
                   "Square Sizes" => SQUARE_CANVAS_SIZES }

  validates :name, :email, :size, presence: true
end
