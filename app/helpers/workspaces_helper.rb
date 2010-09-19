module WorkspacesHelper

  def show_operate_by_status(workspace)
    membership = Membership.find_by_workspace_id_and_email(workspace.id,current_user.email)
    return "" if workspace.user == current_user || workspace.baned_member_emails.include?(current_user.email)
    case true
    when workspace.member_emails.include?(current_user.email)
      return link_to "退出",quit_workspace_memberships_path(workspace,:code=>membership.uuid_code)
    when workspace.apply_member_emails.include?(current_user.email)
      return "已经申请，请等待"
    else
      return link_to "申请",apply_join_workspace_memberships_path(workspace),:method=>:post
    end
  end

  def operate_info(info)
    workspace = info.workspace
    avatar_str = "#{avatar(info.email,:tiny)} #{info.email}"
    document = Document.find(:repo_user_id=>workspace.user_id,:repo_name=>workspace.id,:id=>info.discussion_id.to_s)
    discussion_str = link_to document.title,"workspaces/#{workspace.id}/documents/#{info.discussion_id} "
    worksapce_str = link_to workspace.name,"workspaces/#{workspace.id}"
    text_pin = document.find_text_pin(info.text_pin_id) if !info.text_pin_id.blank?
    operate_str = case info.operate
    when 'create' then "创建 话题"
    when 'reply' then "回复内容 #{text_pin.to_html} 到话题"
    when 'delete' then "删除了内容 在话题"
    when 'edit' then "编辑了内容 #{text_pin.to_html} 到话题"
    end
    "#{avatar_str}在空间 #{worksapce_str} 中 #{operate_str} #{discussion_str}  #{qdatetime info.date}"
  end
    
end
