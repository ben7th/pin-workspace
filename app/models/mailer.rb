class Mailer < ActionMailer::Base
  
  # 邀请某人进入工作空间
  def welcome_to_workspace(workspace,message,emails)
    @recipients = emails
    @from = 'MindPin<noreply@mindpin.com>'
    @body = {'workspace' => workspace,"message"=>message}
    @subject = "欢迎加入我的工作空间"
    @sent_on = Time.now
    @content_type = "text/html"
  end

end