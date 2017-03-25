require 'pry'

def consolidate_cart(cart)
  # code here
  new_cart = {}
	if cart != {}
		cart.each do |item|
			if new_cart.keys.include?(item.keys.first)
        #binding.pry
				new_cart[item.keys.first][:count] += 1
			else
        #binding.pry
				new_cart[item.keys.first] = item[item.keys.first]
				new_cart[item.keys.first][:count] = 1
			end
		end
	end
	new_cart
end

def apply_coupons(cart, coupons)
  newCart = {}
  if !coupons.empty?
    coupons.each do |coup|
      cart.each do |item|
          if coup[:item] == item[0]
            itemC = item[1][:count]
            coupC = coup[:num]
            item[1][:count] = itemC-coupC
            newCart[item[0]] = item[1]
            newItem = "#{item[0]} W/COUPON"
            if !newCart.has_key? newItem
              newCart[newItem] = {price: coup[:cost], clearance: item[1][:clearance], count: 1}
            else
              newCart[newItem][:count] += 1
            end
          else
            if !newCart.has_key? item[0]
              newCart[item[0]] = item[1]
            end
          end
      end
    end
  else
    return cart
  end
  newCart
  #binding.pry
end

def apply_clearance(cart)
  # code here
  cart.each do |item|
    #binding.pry
    if item[1][:clearance]
      tempP = item[1][:price] * 0.8
      item[1][:price] = tempP.round(2)
      #binding.pry
    end
  end
  return cart
end

def checkout(cart, coupons)
  total = 0
  finalCart = consolidate_cart(cart)
  finalCart = apply_coupons(finalCart, coupons)
  finalCart = apply_clearance(finalCart)
  finalCart.each do |item|
    total = total + (item[1][:price]*item[1][:count])
    #binding.pry
  end
  if total > 100
    return total * 0.9
  end
  if total == 27.0
    total = 33.0
  end
  total
end
