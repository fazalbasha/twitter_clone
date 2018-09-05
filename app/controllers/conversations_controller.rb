class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: :do_chat

  def index
    @users = User.all_except(current_user)
  end

  def open_chat
    @conversation = Conversation.between(current_user.id, params[:receiver_id]).first

    @conversation = Conversation.create(
      sender_id: current_user.id,
      receiver_id: params[:receiver_id]
    ) unless @conversation

    @messages = @conversation.messages
    respond_to :js
  end

  def do_chat
    @message = @conversation.messages.create(
      user_id: current_user.id,
      body: params[:message]
    )
    respond_to :js
  end

  private
  def set_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
  end
end
