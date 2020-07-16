def consolidate_cart(cart)
consolidated_cart = {}
  cart.each do |item_data|
    item_data.each do |item, details|
      if  consolidated_cart.keys.include?(item)
        consolidated_cart[item][:count] += 1
       else
        consolidated_cart[item] = details
        consolidated_cart[item][:count] = 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)

  cart.each do |keys, info|
    coupons.each do |coupon|

      item = coupon[:item]
      cost = coupon[:cost]
      number_discounts = coupon[:num]

      if item == keys && cart["#{keys} W/COUPON"] == nil && cart[keys][:count] >= number_discounts

        cart[keys][:count] -= number_discounts
        cart = cart.clone
        cart["#{keys} W/COUPON"] = {:price => cost, :clearance => cart[keys][:clearance], :count => 1 }

        elsif item == keys && cart[keys][:count] >= number_discounts

         cart[keys][:count] -= number_discounts
         cart["#{keys} W/COUPON"][:count] += 1
        end
      end
    end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  cart
 end
 def checkout(cart, coupons)

  consolidated_cart = consolidate_cart(cart)

   applied_coupons = apply_coupons(consolidated_cart, coupons)

   applied_clearance = apply_clearance(applied_coupons)

   total_cost = 0.0

   applied_clearance.each do |item, details|
     total_cost += (details[:price] * details[:count])
  end

   if total_cost > 100.0
     total_cost = total_cost * 0.90
   end

   return total_cost
  end
