require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  
  test "增加某人到工作空间，该人直接退出" do
    lifei = users(:lifei)
    workspace = workspaces(:workspace_number_one)
    session[:user_id] = lifei.id
    assert_difference("Membership.count",1) do
      post :add_members,:workspace_id=>workspace.id,:emails=>"chinachengliwen@gmail.com"
    end
    membership = Membership.last
    assert_equal membership.status,Membership::JOINED 
    assert_equal membership.email,"chinachengliwen@gmail.com"
    uuid_code = membership.uuid_code

    # 该人退出
    get :quit,:code=>uuid_code,:workspace_id=>workspace.id
    membership.reload
    assert_equal membership.status,Membership::QUIT
  end

  test "邀请某人到工作空间，该人加入后退出" do
    lifei = users(:lifei)
    workspace = workspaces(:workspace_number_one)
    session[:user_id] = lifei.id
    assert_difference("Membership.count",1) do
      post :invite_members,:workspace_id=>workspace.id,:emails=>"chinachengliwen@gmail.com"
    end
    membership = Membership.last
    assert_equal membership.status,Membership::INVITE
    code = membership.uuid_code

    # 该人加入
    get :join,:code=>code,:workspace_id=>workspace.id
    assert_equal membership.reload.status,Membership::JOINED
    
    # 该人退出
    get :quit,:code=>code,:workspace_id=>workspace.id
    assert_equal membership.reload.status,Membership::QUIT
  end

  test "用户主动申请加入工作空间" do
    lucy = users(:lucy)
    session[:user_id] = lucy.id
    workspace = workspaces(:workspace_number_one)
    assert_difference("Membership.count",1) do
      post :apply_join,:workspace_id=>workspace.id
    end
    membership = Membership.last
    assert_equal membership.status,Membership::APPLY
  end

  test "同意某人的申请" do
    lucy = users(:lucy)
    workspace = workspaces(:workspace_number_one)
    lucy.apply_join(workspace)
    membership = Membership.last
    assert_difference("Membership.count",0) do
      put :approve,:workspace_id=>workspace.id,:id=>membership.id
    end
    assert_equal membership.reload.status,Membership::JOINED
  end

  test "拒绝某人的申请" do
    lucy = users(:lucy)
    workspace = workspaces(:workspace_number_one)
    lucy.apply_join(workspace)
    membership = Membership.last
    assert_difference("Membership.count",0) do
      put :refuse,:workspace_id=>workspace.id,:id=>membership.id
    end
    assert_equal membership.reload.status,Membership::REFUSED
  end

end
