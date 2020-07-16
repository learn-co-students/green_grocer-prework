require 'pry'

def consolidate_cart(cart)
  # code here
  consolidated_hash = {}
  cart.each do |cart_item|
    if consolidated_hash[cart_item.keys[0]] == nil
      items_to_consolidate = cart.select{|element| element == cart_item}
      consolidated_hash[cart_item.keys[0]] = cart_item[cart_item.keys[0]]
      consolidated_hash[cart_item.keys[0]][:count] = items_to_consolidate.size
    end
  end
  consolidated_hash
end


def apply_coupons(cart, coupons)
  if coupons != []
    # code here
    couponed_cart = {}
    cart.each do |cart_item|
      coupons.each do |each_coupon|
        if cart_item[0] == each_coupon[:item] && cart_item[1][:count] - each_coupon[:num]>=0
          #binding.pry
          cart_item[1][:count] = cart_item[1][:count] - each_coupon[:num]
          
          couponed_cart[cart_item[0]] = cart_item[1]
          if couponed_cart["#{cart_item[0]} W/COUPON"] == nil
            couponed_cart["#{cart_item[0]} W/COUPON"] = {
              :price => each_coupon[:cost],
              :clearance => cart_item[1][:clearance],
              :count => 1
            }
          else
            couponed_cart["#{cart_item[0]} W/COUPON"][:count] = couponed_cart["#{cart_item[0]} W/COUPON"][:count] + 1
          end
        else
          couponed_cart[cart_item[0]] = cart_item[1]
        end
      end
    end
    couponed_cart
  else
    cart
  end
end

def apply_clearance(cart)
  # code here
  cart.each do |cart_item|
    if cart_item[1][:clearance]== true
      cart_item[1][:price] = (cart_item[1][:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_items = apply_coupons(consolidated_cart, coupons)
  clearanced_items = apply_clearance(couponed_items)
  sum_arr = []
  clearanced_items.each do |each_item|
    sum_arr << each_item[1][:price] * each_item[1][:count]
  end
  tot_cost = 0
  sum_arr.each do |each_cost|
    tot_cost = tot_cost += each_cost
  end
  if tot_cost < 100
    tot_cost
  else
    tot_cost * 0.9
  end
end
