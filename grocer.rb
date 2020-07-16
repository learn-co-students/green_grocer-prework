require 'pry'


#cart = {
#  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#  "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
#}


#coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}



def consolidate_cart(cart)
output = {}

cart.each do |item|
  item.each do |label, values|
    if output.keys.include?(label) == false

      output[label] = values
      output[label][:count] = 1

    else
      output[label][:count] += 1
    end


  end

end


output

end



def apply_coupons(cart, coupons)
  # code here

    coupons.each do |coupon|
      cart.keys.each do |item|
        if coupon[:item] == item && cart[item][:count] >= coupon[:num]
          cart["#{item} W/COUPON"] = {
            price: coupon[:cost],
            clearance: cart[item][:clearance],
            count: cart[item][:count] / coupon[:num]
          }
          cart[item][:count] -= (cart[item][:count] / coupon[:num]) * coupon[:num]

        end

      end
    end
    cart

  end



def apply_clearance(cart)


    cart.each do |item, details|
      if details[:clearance] == true
        details[:price] = (details[:price] * 0.8).round(1)

      end
    end

cart
end

def checkout(cart, coupons)

consolidated_cart = consolidate_cart(cart)
couponed_cart = apply_coupons(consolidated_cart, coupons)
clearnced_cart = apply_clearance(couponed_cart)

price_total = 0

clearnced_cart.each do |item, details|
  price_total += details[:price] * details[:count]

end
if price_total > 100
price_total = price_total * 0.9
end
price_total
end
