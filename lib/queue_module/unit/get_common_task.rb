module QueueModule
  module Unit
    module GetCommonTask
      def perform
        begin
          agent = Mechanize.new do |a|
            a.log              = Logger.new "log/mech.log"
            a.user_agent_alias = "Mac Safari"
            a.read_timeout     = 120
            a.idle_timeout     = 120
            a.keep_alive       = false
            #a.pre_connect_hooks << Proc.new { p "pre connect" }
            #a.post_connect_hooks << Proc.new { p "post connect" }
          end
          Rails.logger.info @task.data[:url]
          page = agent.get @task.data[:url]
          Rails.logger.info "Got page"
          result = @parser.parse page, domain(@task.data[:url])
        rescue Exception => e
          @last_exception = e
          result          = false
        end
        result
      end

      private

      def domain page
        parsed = URI.parse(page)
        scheme = (parsed.scheme.nil? ? "http" : parsed.scheme) + "://"
        scheme + parsed.host.downcase
      end
    end
  end
end