def consolidate_cart(cart)
  new_cart = {}
  cart.each_with_index do |item, index|
    item.each do |food, details|
      if new_cart[food]
        new_cart[food][:count] += 1
      else
        new_cart[food] = details
        new_cart[food][:count] = 1
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    if !cart[item].nil? && cart[item][:count] >= coupon[:num]
      new_item = {"#{item} W/COUPON" => {
        :price => coupon[:cost],
        :clearance => cart[item][:clearance],
        :count => 1
        }
      }
      if cart["#{item} W/COUPON"].nil?
        cart.merge!(new_item)
      else
        cart["#{item} W/COUPON"][:count] += 1
      end
      cart[item][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food, info|
    if info[:clearance] == true
      info[:price] = info[:price] - (info[:price]/5)
    end
  end
  cart
end

# def checkout(cart, coupons)
#   total_cost = []
#   new_cart = consolidate_cart(cart)
#   new_cart_2 = apply_coupons(new_cart, coupons)
#   new_cart_3 = apply_clearance(new_cart_2)
#
#   new_cart_3.each do |name, info|
#     total_cost << info[:price] * info[:count]
#   end
#     total_cost_sum = total_cost.inject(0){|sum, x| sum + x}
#   if total_cost_sum > 100
#     new_total = total_cost_sum - (total_cost_sum/5)
#   end
#   new_total
# end


def checkout(items, coupons)
  new_cart = consolidate_cart(items)
  new_cart_1 = apply_coupons(new_cart, coupons)
  new_cart_2 = apply_clearance(new_cart_1)

  total = 0

  new_cart_2.each do |name, info|
    total += info[:price] * info[:count]
  end

  if total > 100
    new_total = total - (total/10)
    new_total
  else total
  end

end
