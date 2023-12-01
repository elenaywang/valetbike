class PaymentsController < ApplicationController
    # def index
    #     @payment = Payment.order(:first_name)
    # end

    def show
        #@user = current_user
        @payment = Payment.find_by(user_id: current_user.id)
    end

    def new
        @user = current_user
        @payment = Payment.new
    end

    def create
       if current_user.payment_id.blank?
        @payment = Payment.new(payment_params) 
        @payment.user_id = params[:user_id]
            if @payment.save
                puts @payment.id
                current_user.update_column(:payment_id, @payment.id)
                redirect_to user_payments_path
            else
                render('new')
            end
        else
            redirect_to user_payments_path
        end
    end

    private
    def payment_params
      params.require(:payment).permit(:first_name, :last_name, :card_number, :cvv, :exp_month, :exp_year)
    end

end
  

# #   def edit
# #     @payment = Payment.find(params[:id])
# #   end

# #   def update
# #     @payment = Payment.find(params[:id])
# #     if @payment.update(payment_params)
# #         redirect_to payment_path(@payment)
# #     else
# #         render('edit')
# #     end
# #   end

## end
