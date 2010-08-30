class User < UserBase
  include Workspace::UserMethods
  include Membership::UserMethods

  def self.create_email_discusser(email)
    if User.find_by_email(email).blank?
      self.create!(:name=>email,:email=>email)
    end
  end
end