module ApplicationHelper
  def tab_header(*paths)
    base = "tab flex justify-center hover:text-[#2C1AA1] font-prompt text-xs md:text-sm lg:text-base"
    active = "tab-active rounded-underline font-semibold text-[#2C1AA1]"

    is_active = paths.any? { |p| current_page?(p) || request.path.start_with?("#{p}/") }
    "#{base} #{active if is_active}"
  end
end
