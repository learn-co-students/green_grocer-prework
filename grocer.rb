def consolidate_cart(cart)
end_cart = Hash.new(0)
  cart.each do |item|
   name, data = item.first
   if 
     end_cart.has_key?(name)
     end_cart[name][:count] += 1 
   else
     end_cart[name] = data
     end_cart[name][:count] = 1 
   end
 end
 end_cart
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    discounted = coupon[:item]
    if cart.has_key?(discounted) && cart[discounted][:count] >= coupon[:num]
      cart[discounted][:count] -= coupon[:num]
      new_item = "#{discounted} W/COUPON"
      if cart.has_key?(new_item)
        count = cart[new_item][:count] + 1 
      else
        count = 1
      end
      cart[new_item] = {
        :price => coupon[:cost],
        :clearance => cart[discounted][:clearance],
        :count => count
      }
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, data|
    if 
      data[:clearance] == true 
      data[:price] = (data[:price] *0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cost = 0 
  cart.each do |item, data|
    cost += data[:price] * data[:count]
  end
  if cost > 100
      cost *= 0.9
  end
  cost.round(2)
end
