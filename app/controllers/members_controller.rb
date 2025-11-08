class MembersController < ApplicationController
  before_action :set_list

  def create
    user = User.find_by(email: params[:email])

    if user
      @member = @list.members.new(user: user)
      @member.status = "accepted"  # ✅ força aceitação automática

      if @member.save
        redirect_to @list, notice: "Membro adicionado com sucesso!"
      else
        redirect_to @list, alert: "Não foi possível adicionar o membro."
      end
    else
      redirect_to @list, alert: "Usuário não encontrado."
    end
  end

  def destroy
    @member = @list.members.find(params[:id])

    if @member.user == @list.owner
      redirect_to @list, alert: "O dono da lista não pode ser removido."
    else
      @member.destroy
      redirect_to @list, notice: "Membro removido com sucesso."
    end
  end

  private

  # ✅ Alterado para funcionar com FriendlyId
  def set_list
    @list = List.friendly.find(params[:list_id])
  end

  def member_params
    params.require(:member).permit(:user_id, :list_id, :status)
  end
end
