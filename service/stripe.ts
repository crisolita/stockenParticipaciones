import { PrismaClient } from "@prisma/client";
import { getUserById } from "./user";
import { LargeNumberLike } from "crypto";
const stripe = require('stripe')(process.env.SK_TEST);

export const createTransfer = async (receiverAccountId:string,amount:string,description:string, prisma: PrismaClient) => {
  const transfer = await stripe.transfers.create({
    amount: amount,
    currency: 'usd',
    destination: receiverAccountId,
    description:description,
  });
  };
  export const createCharge = async (user_id:number,receiverAccountId:string,cardNumber:string, exp_month:string,exp_year:string,cvc:string, amount:string,prisma: PrismaClient) => {
    try {
      const user= await getUserById(user_id,prisma)
      const customer = await stripe.customers.create({description:`${user_id}`
      , email:user?.email})
      const paymentMethod = await stripe.paymentMethods.create({
          type: 'card', 
          card: {
            number: cardNumber,
            exp_month: exp_month,
            exp_year: exp_year,
            cvc: cvc,
          },
        });
        const attach= await stripe.paymentMethods.attach(
          paymentMethod.id,
          {customer: customer.id}
        );
        const charge = await stripe.paymentIntents.create({
          amount: amount,
          currency: 'usd',
          payment_method:paymentMethod.id,
          confirm:true,
          application_fee_amount:'10',
          customer:customer.id,
          receipt_email:user?.email,
          transfer_data:{
            destination:receiverAccountId
          }
        })
        const balance = await stripe.balance.retrieve();
        console.log(balance,"un balance que debria estar bueno")
        return true;
    } catch(e) {
      console.log(e)
      return false
    }
   
    };

