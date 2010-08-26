class MembershipsController < ApplicationController

  before_filter :per_load
  def per_load
    @workspace = Workspace.find(params[:workspace_id]) if params[:workspace_id]
  end

  def create
    workspace_id = params[:membership][:workspace_id]
    email = params[:membership][:email]
    @membership = Workspace.find(workspace_id).add_member(email)
    if @membership
      render :xml=>@membership.to_xml
    end
  end

  def add_members_form
  end

  def add_members
    @emails = params[:emails].split(/,|，|\n/)
    @message = params[:message]
    # 发送邮件
    @workspace.add_members(@emails)
    @emails.each{|email|Mailer.deliver_welcome_to_workspace(@workspace,@message,email)}
    render :template=>"/memberships/add_success"
  end

  def invite_members_form
  end

  def invite_members
    @emails = params[:emails].split(/,|，|\n/)
    @message = params[:message]
    # 发送邮件
    @workspace.invite_members(@emails)
    @emails.each{|email|Mailer.deliver_invite_to_workspace(@workspace,@message,email)}
    render :template=>"/memberships/invite_success"
  end

  def add_success
  end

  def quit
    membership = Membership.find_by_uuid_code(params[:code])
    if membership.quit
      return render :template=>"/memberships/quit_success"
    end
    render :template=>"/memberships/aleady_quited"
  end

  def join
    membership = Membership.find_by_uuid_code(params[:code])
    if membership.join
      return render :template=>"/memberships/join_success"
    end
    render :template=>"/memberships/already_joined"
  end
  
end