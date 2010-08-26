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
    Mailer.deliver_welcome_to_workspace(@workspace,@message,@emails)
    render :action=>:add_success
  end

  def add_success
  end
  
end