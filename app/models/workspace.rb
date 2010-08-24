class Workspace < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name

  after_create :create_repository
  def create_repository
    WorkspaceGitRepository.create(:user=>self.user,:repo_name=>self.id)
  end
end
