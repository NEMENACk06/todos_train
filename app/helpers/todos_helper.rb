module TodosHelper
  # ข้อความที่จะแสดง (แก้เป็นไทย/ใช้ i18n ก็ได้)
  def priority_label(todo)
    case todo.priority_level
    when "important_urgent"         then "สำคัญและเร่งด่วน"
    when "important_not_urgent"     then "สำคัญแต่ไม่เร่งด่วน"
    when "not_important_urgent"     then "ไม่สำคัญแต่เร่งด่วน"
    else                                 "ไม่สำคัญและไม่เร่งด่วน"
    end
  end

  # คลาสสีของ badge
  def priority_badge_class(todo)
    case todo.priority_level
    when "important_urgent"         then "bg-red-500 text-white"
    when "important_not_urgent"     then "bg-yellow-400 text-gray-800"
    when "not_important_urgent"     then "bg-blue-500 text-white"
    else                                 "bg-gray-300 text-gray-800"
    end
  end

  PRIORITY_OPTIONS = {
    "not_important_not_urgent" => "ไม่สำคัญและไม่เร่งด่วน",
    "important_not_urgent"     => "สำคัญแต่ไม่เร่งด่วน",
    "not_important_urgent"     => "ไม่สำคัญแต่เร่งด่วน",
    "important_urgent"         => "สำคัญและเร่งด่วน"
  }.freeze

  def priority_options_for_select
    Todo.priority_levels.keys.map { |k| [PRIORITY_OPTIONS[k], k] }
  end
end
