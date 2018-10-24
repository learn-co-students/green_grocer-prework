require 'pry'

def consolidate_cart(cart)
  # cart is a list, but return value must be a hash (per the assign)
  new_cart = {}
  # consolidate the old cart into the new cart. For each product in the cart,
  cart.each do |product|
    product.each do |product_name, product_info|
      # if the item is not in new_cart but item does not have a count,
      # add it to new_cart and set count to 1
      if !new_cart.keys.include?(product_name)
        new_cart[product_name] = product_info
        new_cart[product_name][:count] = 1
      # if item is in new_cart but item does not have a count, increment by 1
      else
        new_cart[product_name][:count] += 1
      end
    end
  end
  return new_cart
  # note: cart count will also be updated for each entry, but new_cart
  # will only have one entry per item, so the return value will be correct
end

def apply_coupons (cart, coupons)
  # new hash may be required to add new keys to the hash during a loop
  new_cart = {}

  # for each item in the cart
  cart.each do | product_name,product_info |
    coupons.each do |coupon|

      # does a coupon apply to that product? If no - then just add the product
      if coupon[:item] === product_name

        # enough product for the coupon to apply? if no, skip to next product.
        if product_info[:count] >= coupon[:num]

          # if w/coupon hasn't been added yet, then add it
          if new_cart["#{product_name} W/COUPON"] === nil
            new_cart["#{product_name} W/COUPON"] = {}
            new_cart["#{product_name} W/COUPON"][:price] = coupon[:cost]
            new_cart["#{product_name} W/COUPON"][:clearance] = product_info[:clearance]
            new_cart["#{product_name} W/COUPON"][:count] = 0
          end

          # increment new_cart item and decrement cart item
          while product_info[:count] - coupon[:num] >= 0
              product_info[:count] -= coupon[:num]
              new_cart["#{product_name} W/COUPON"][:count] += 1
          end

          # if there are 0 or more products left in the cart,
          # then add product to the new cart
          if product_info[:count] >= 0
            new_cart[product_name] = product_info
          end
        end
      end
    end
    # if no coupon applied and product_name hasn't already been added to
    # new_cart, then add product_name to the new_cart
    if !new_cart.keys.include?(product_name)
      new_cart[product_name] = product_info
    end
  end
  return new_cart
end


def apply_clearance(cart)
  # code here
  cart.each do | name,values |
    if cart[name][:clearance] == true
      reduced_price = cart[name][:price]*0.8
      cart[name][:price] = reduced_price.round(2)
      # reset :clearance to false, so that the price isn't adjusted more than
      # once for subsequent calls
      cart[name][:clearance] = false
    end
  end
end


def checkout(cart, coupons)
  # call each of the functions defined in this file, in the correct order
  new_cart = consolidate_cart(cart)
  new_cart = apply_coupons(new_cart, coupons)
  new_cart = apply_clearance(new_cart)

  # then, set total to zero, then loop through final_cart and increment total
  total = 0
  new_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end

  # implement the special saving rule for when the cart is over $100
  if total > 100
    total = total * 0.9
  end
  total
end

=begin

def consolidate_cart_passes(cart)
  # cart is a list, but return value must be a hash (per the assign)
  # create new cart
  new_cart = {}
  # consolidate the old cart into the new cart
    # for each product in the cart,
  cart.each do |product|

    #I THINK THE LOGIC HERE IS WONKY, WHY IS THE LOOP INSIDE THE IF STATEMENT?

    # if the item is not in new_cart, add it to new_cart
    if !new_cart.keys.include?(product.keys[0])
      product.each do |product_name, product_info|
        new_cart[product_name] = product_info
        new_cart[product_name][:count] = 1
      end
      # else increase new_cart[item] count by cart[item] count
    else
      binding.pry
      if !product[:count] === nil
        binding.pry
        new_cart[product.keys[0]][:count] += product[:count]
      else
        new_cart[product.keys[0]][:count] += 1
      end
    end
  end
  # return the new cart
  return new_cart
end

def consolidate_cart_old(cart)
  # code here
  cart.each do |original_hash|
    original_hash.each do |k,v|
      original_hash[k][:count] = 0
      product = original_hash.keys
      cart.each do |hash|
        hash.each do |k,v|
          if hash.keys == product
            original_hash[k][:count] +=1
          end
        end
      end
    end
  end
  new_object = {}
  cart.uniq.each do |element|
    element.each do |k,v|
      new_object[k]=v
    end
  end
  return new_object
end

def apply_coupons_original(cart, coupons)
  # code here
  new_cart = {}
  coupons.each do |coupon|
    cart.each do |product_name,info|
      if new_cart["#{product_name} W/COUPON"] == nil
        if coupon[:item] == product_name
          new_cart["#{product_name} W/COUPON"] = {}
          new_cart["#{product_name} W/COUPON"][:clearance] = cart[product_name][:clearance]
          new_cart["#{product_name} W/COUPON"][:price] = coupon[:cost]
          new_cart[product_name] = info
          new_cart["#{product_name} W/COUPON"][:count] = 0
          while new_cart[product_name][:count] >= coupon[:num]
              new_cart[product_name][:count] -= coupon[:num]
              new_cart["#{product_name} W/COUPON"][:count] += 1
          end
        end
      end
    end
  end
  if new_cart.keys != []
    return new_cart
  else
    return cart
  end
end

def apply_coupons_flatiron (cart, coupons)
  # function may use this new hash to temporarily store new keys during a loop
  coupon_cart = {}

  # for each cart_item in the cart
  cart.each do |item|
    coupons.each do |coupon|

      # does a coupon apply to that item? If no - skip to next item.
      if item[0] === coupon[:item]

        # enough items for the coupon to apply? if no, skip to next item.
        if item[1][:count] >= coupon[:num]

          # add "AVOCADO W/COUPON" to the coupon_cart if not already included.
          if !coupon_cart.keys.include?("#{coupon[:item]} W/COUPON")
            coupon_cart["#{coupon[:item]} W/COUPON"] = item[1]
          end
            # while item count above 0, decrement item count and increment
            # coupon_cart item count
          while item[1][:count] > 0
              item[1][:count] -= coupon[:num]
              coupon_cart["#{coupon[:item]} W/COUPON"][:count] += 1
          end
        end
      end
    end
  end
  # return cart (if you use an assignment (=),
  # then you mutate the original element)
  return cart.merge(coupon_cart)
end
=end
