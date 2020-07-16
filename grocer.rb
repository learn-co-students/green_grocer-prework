def consolidate_cart(cart)
  new_hash = {}
  temp_hash = {}
  item_count = 0

  cart.each do |item_hash|
    item_count = cart.count(item_hash)

    item_hash.each do |item, value|

        new_hash[item] = value
        new_hash[item][:count] = item_count

    end

  end
  new_hash
  # code here
end

def apply_coupons(cart, coupons)

  new_cart = cart
  coupon_name_array = []
  coupon_hash_array = []
  coupon_multiplier = 1

  coupons.each do |coupon|
    coupon_multiplier = coupons.count(coupon)
    cart.each do |item_name, values|

      if coupon[:item] == item_name #if item matches on coupon
        if values[:count] - coupon[:num] >= 0
          new_cart[item_name][:count] = values[:count] - coupon[:num] #remainder of items after bundling
        else
          coupon_multiplier-=1
        end
        coupon_name = "#{item_name} W/COUPON"
        coupon_price = coupon[:cost]
        coupon_name_array << coupon_name
        coupon_hash_array << {:price => coupon_price,
                             :clearance => values[:clearance],
                             :count => coupon_multiplier}
      cart = new_cart
      end
    end
  end
  i = 0

  while i < coupon_name_array.length
    new_cart[coupon_name_array[i]] = coupon_hash_array[i]
    i+=1
  end

  #cart.delete_if do |item, value_data| new_cart[item][:count] <= 0 end #Deletes entries if there are no remainders
new_cart
end

def apply_clearance(cart)
  discount_cart = cart

  cart.each do |item, values|
    if values[:clearance]
      discount_cart[item][:price] = (values[:price]*0.8).round(2)
    end
  end

  discount_cart
  # code here
end

def checkout(cart, coupons)
  cost = 0

  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart,coupons)
  new_cart = apply_clearance(new_cart)

  new_cart.each do |items, values|
   cost += values[:price]*values[:count]
  end
  if cost > 100
    cost = (cost * 0.9).round(2)
  else
    cost
  end
    # code here
end
