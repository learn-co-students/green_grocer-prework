def consolidate_cart(cart)
  # code here
  empty_hash = {}
  empty_array = []
  cart.each do |item_array|
    item_array.each do |item_key, item_hash|
      empty_array.push(item_key)
    end
  end
  cart.each do |item_array|
    item_array.each do |item, items_hash|
      empty_hash[item] = items_hash
      empty_hash[item][:count] = empty_array.count(item)
    end
  end
  empty_hash
end

def apply_coupons(cart, coupons)
  # code here
  empty_hash = {}
  item_name_array = []
  hash_array = []
  counter = 0
  coupons.each do |coupon|
    cart.each do |item, item_hash|
      if coupon[:item] == item
        if (cart[item][:count])/(coupon[:num]) >= 1
          item_name_array.push("#{item} W/COUPON")
          hash_array.push({price: coupon[:cost], clearance: cart[item][:clearance], count: cart[item][:count]/coupon[:num]})
          cart[item][:count] = (cart[item][:count]) - (coupon[:num])
        end
      end
    end
  end
  while counter < item_name_array.length
    if cart[item_name_array[counter]] == nil
      cart[item_name_array[counter]] = hash_array[counter]
      counter += 1
    else
      cart[item_name_array[counter]][:count]
      counter += 1
    end
  end
  cart
end


def apply_clearance(cart)
  # code here
  price = 0
  cart.each do |item, item_hash|
    if cart[item][:clearance] == true
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
  cart
end



def checkout(cart, coupons)
  # code here
  cart_total = 0
  cart = apply_coupons(consolidate_cart(cart), coupons)
  cart = apply_clearance(cart)

  cart.each do |item, item_hash|
    cart_total = cart_total + (cart[item][:price] * cart[item][:count])
  end

  if cart_total > 100
    cart_total = cart_total * 0.90
  end

  cart_total
end
