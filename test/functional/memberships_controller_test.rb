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

end
