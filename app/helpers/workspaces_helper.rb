module WorkspacesHelper

  def show_operate_by_status(workspace)
    membership = Membership.find_by_workspace_id_and_email(workspace.id,current_user.email)
    case true
    when workspace.member_emails.include?(current_user.email)
      return link_to "退出",quit_workspace_memberships_path(workspace,:code=>membership.uuid_code)
    when workspace.apply_member_emails.include?(current_user.email)
      return "已经申请，请等待"
    when workspace.user == current_user
      return ""
    else
      return link_to "申请",apply_join_workspace_memberships_path(workspace),:method=>:post
    end
  end
    
end
