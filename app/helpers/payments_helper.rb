module PaymentsHelper
    def display_alerts
        html = <<-HTML
        <div class="flash" id="#{:alert}">
            <div class="text">
              #{flash[:alert]}
          </div>
        </div>
        HTML
            html.html_safe if flash[:alert]
          end
end
