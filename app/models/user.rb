class User < UserBase
  include Workspace::UserMethods
  include Membership::UserMethods
end