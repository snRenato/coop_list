class MembersController < ApplicationController
before_action :set_list

  def create
    # Cria o membro automaticamente como accepted
    email = params[:email].strip.downcase
    user = User.find_by(email: email)
    @member = @list.members.build(user: user, status: :accepted)


    if @member.save
      respond_to do |format|
        format.turbo_stream # para atualizar o Turbo Frame
        format.html { redirect_to @list, notice: "#{user.email} adicionado à lista!" }
      end
    else
      redirect_to @list, alert: @member.errors.full_messages.to_sentence
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def member_params
    params.require(:member).permit(:user_id, :list_id, :status)
  end
end
