
def consolidate_cart(cart)
  # code here
  #new variables
  cart_update = {}
  count = Hash.new(0)

  #count keys
  cart.each do |key|
    count[key] += 1
  end

 #create new hash with counts
  count.each do |key, value|
    key.each do |food, data|
      cart_update[food] = data
      cart_update[food].merge!(:count => value)
    end
  end
  return cart_update
end


#Apply coupons was one of the hardest methods I had to put together so far.
# The below code works to pass the tests, but I think I am not sure that it is worthy
# for a real application. The code below is also very very smelly.

def apply_coupons(cart, coupon_array)
  # code here

##coupon count block to account for multiple coupons, and increment them
coupon_update_array = []
 coupon_update_hash = {}
  coupon_count = Hash.new(0)

 coupon_array.each do |coupon_element|
    coupon_element.each do |key, value|
      if key == :item
       coupon_count[value] += 1
     end
  end
end

coupon_array.each do |coupon_element|
  coupon_element.each do |item, avocado|
    coupon_count.each do |name, count|
      if avocado == name
      coupon_update_hash[coupon_element] = count
      end
   end
 end
end

coupon_update_hash.each do |coupon_info, count|
  coupon_info[:total_count] = 0
  coupon_info.merge!(:count => count)
end

coupon_update_hash.each do |coupon_info, count|
  coupon_info.each do |key, value|
    if key == :num
      coupon_info[:total_count] = count * value
    end
  end
end

#The code below takes care of multiple coupons for not having enough items to take advantage of the sale
# If this is the case, the coupon_update_hash information is adjusted to delete coupons that
# will not be eligible for use, since the client may not have enough items in their cart.
cart.each do |item, item_info|
  coupon_update_hash.each do |coupon_info, count|
    coupon_info.each do |coupon_key, coupon_value|
      if coupon_key == :item && item == coupon_value
       item_info.each do |item_key, item_value|
        if item_key == :count
         coupon_info.each do |coupon_key1, coupon_value1|
           if coupon_key1 == :total_count && coupon_value1 > item_value
            coupon_info.each do |coupon_key2, coupon_value2|
              if coupon_key2 == :num
                coupon_info[:total_count] = coupon_value1 - coupon_value2
                end
                 if coupon_key2 == :count
                  coupon_info[:count] = coupon_value2 - 1
                 end
               end
             end
           end
         end
       end
     end
   end
  end
end


## Block below will return the cart in the event that no coupons are given,
  #or no coupons apply
  coupon_names = []
    coupon_array.each do |coupons|
      coupons.each do |food_key, food_data|
        if food_key == :item
          coupon_names.push(food_data)
        end
     end
  end

  coupons_that_apply_to_cart = []
  cart.each do |food_name, food_data|
    if coupon_names.include?(food_name)
      coupons_that_apply_to_cart.push(food_name)
    end
  end
  if coupons_that_apply_to_cart.length == 0
    return cart
  end

##This block will return the cart if they are not enough items in the cart
## for the coupon to apply. This method does not account for multiple coupons
## it looks at one coupon at a time. The method above accounts for the multiple coupons.
## This method counts the items in the cart
  food_item_count = []
  cart.each do |food_name, food_info|
    coupons_that_apply_to_cart.each do |coupon_name|
      if food_name == coupon_name
        food_info.each do |key, value|
          if key == :count
            food_item_count.push({food_name => value})
          end
        end
      end
    end
  end

 # This method counts the items that you need to apply the coupon
  food_coupon_count = []
  coupon_update_hash.each do |coupon_data, count|
    coupon_data.each do |key, value|
      coupons_that_apply_to_cart.each do |coupon_name|
      if key == :item && value == coupon_name
        coupon_data.each do |key, value|
          if key == :num
            food_coupon_count.push({coupon_name => value})
          end
        end
      end
    end
   end
  end

  #This method compares the items in the cart, with the items needed to apply the coupon
  # If the item's count in the cart is greater than or equal to the required coupon count
  # The item gets pushed to the qualifying_coupons_based_on_count array.
  qualifying_coupons_based_on_count = []
  food_coupon_count.each do |coupon_info|
    food_item_count.each do |food_info|
      coupon_info.each do |coupon_name, count_coupon|
        food_info.each do |food_name, count_food|
          if food_name == coupon_name && count_food >= count_coupon
            qualifying_coupons_based_on_count.push({coupon_name => count_coupon})
        end
      end
    end
   end
  end

  #If the qualifying_coupons_based_on_count array's length is zero, we return the cart since
  #although the customer may have items that are on sale, they have not bought the appropriate
  # quantities to qualify for the special price
  if qualifying_coupons_based_on_count.length == 0
    return cart
  end

  ## This block of code checks to see if there is any discrepancy between the qualifying_coupons_based_on_count
  # and the coupons_that_apply_to_cart array. If there are any mismatches, we edit the
  # coupons_that_apply_to_cart array, to make sure we do not include them in the final cart
  qualifying_coupons_based_on_count.each do |qualifying_coupon|
  qualifying_coupon.each do |coupon_name, count|
   if !coupons_that_apply_to_cart.include?(coupon_name)
      coupons_that_apply_to_cart.delete(coupon_name)
    end
  end
  end

# This block adds the updated items with the correct format, and
# skeleton

  coupon_item = ""
   coupons_that_apply_to_cart.each do |coupon_name|
     coupon_item = coupon_name + " W/COUPON"
     cart[coupon_item] = {:price => 0, :clearance => 0, :count => 0}
     end

     coupon_array.each do |coupon_element|
       coupon_element.each do |coupon_key, coupon_data|
         coupons_that_apply_to_cart.each do |coupon_name|
         if coupon_key == :item && coupon_data == coupon_name
           coupon_element.each do |coupon_key, coupon_data|
             if coupon_key == :cost
               cart[coupon_name + " W/COUPON"][:price] = coupon_data
             end
           end
         end
       end
     end
   end


## This block will take care of the clearance
  cart.each do |avocado, avocado_info|
    avocado_info.each do |price, price_info|
      coupons_that_apply_to_cart.each do |coupon_name|
        if price == :clearance && avocado == coupon_name
        cart[coupon_name + " W/COUPON"][:clearance] = price_info
        end
      end
    end
  end

## This block will take care of updating the counts for the couponed items
     coupon_update_hash.each do |coupon_info, count|
         coupon_info.each do |item, item_name|
           coupons_that_apply_to_cart.each do |coupon_name|
            if item == :item && item_name == coupon_name
              coupon_info.each do |item1, item_name1|
                if item1 == :count
               cart[coupon_name + " W/COUPON"][:count] = item_name1
                end
              end
           end
        end
      end
    end

## update counts for remainder items that were left as a result of not fitting coupon_info
## parameters
  cart.each do |food_name, food_info|
    food_info.each do |food_key, food_value|
      coupon_update_hash.each do |coupon_info, count|
        coupon_info.each do |coupon_key, coupon_value|
          if coupon_key == :item && coupon_value == food_name
            coupon_info.each do |coupon_key, coupon_value|
              if food_key == :count && coupon_key == :total_count
                cart[food_name][:count] = food_value - coupon_value
              end
            end
          end
        end
      end
    end
  end
return cart
end


def apply_clearance(cart)
 # code here
 cart.each do |food, food_data|
  food_data.each do |key, value|
    if key == :clearance && value == true
      food_data.each do |key, value|
        if key == :price
          cart[food][:price] = ((value * 0.8)*1000).floor/1000.0
        end
      end
    end
  end
end

return cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  consolidated_cart_final = apply_clearance(consolidated_cart_with_coupons)
  total_cart_price = []

  consolidated_cart_final.each do |food, food_values|
    food_values.each do |key, value|
       if key == :price
        food_values.each do |key1, value1|
         if key1 == :count
          total_cart_price.push(value * value1)
          end
        end
      end
    end
  end
      total = 0
      total_cart_price.each do |price|
        total += price
      end

      if total > 100
        return ((total * 0.9)*1000).floor/1000.0
      end

      return total
end
