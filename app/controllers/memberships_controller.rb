class MembershipsController < ApplicationController

  def create
    workspace_id = params[:membership][:workspace_id]
    email = params[:membership][:email]
    @membership = Workspace.find(workspace_id).add_member(email)
    if @membership
      render :xml=>@membership.to_xml
    end
  end
  
end