# we have an array (cart) that has hashes as elements (element_hash).
# element_hash's key is a veggie (item) and the value is a hash (attribute_hash).
# attribute_hash's key is an attribute (eg price, clearance), whose value is an integer or boolean.

# we want a hash (new_hash) whose key is the item and whose value is the attribute_hash,
# with another attribute included (:count). If our array has similar elements,
# the :count should reflect how many times these appear within the cart.

# each with object iterates the given block for each element with an arbitrary object given, and returns
# the initially given object. If no block is given it returns an enumerator.

def consolidate_cart(cart)
  cart.each_with_object({}) do |element_hash, new_hash|
    element_hash.each do |items, attribute_hash|
      if new_hash[items]
        attribute_hash[:count] += 1
      else
        attribute_hash[:count] = 1
        new_hash[items] = attribute_hash
      end
    end
  end
end

# The method is given a hash (cart), whose keys are veggies (items) and whose values are attribute_hash.
# This attribute_hash's keys are attributes (price, clearance, count) and the values are integers, or bouleans.
# In other words, the cart hash is what the consolidate_cart spat out (new_hash).

# coupons are hashes whose key is an attribute (attribute)(:item, :num, :cost) and values are strings or integers.

# The method should return the cart hash but adjusted to account for coupons applied.
# If there is a coupon for a specific item, a new key-value pair should be added.
# the key should be #{item} W/COUPON and the value should be the attribute_hash BUT
# the attribute should reflect the coupon application.
# :price should be the same as coupons[attribute][:cost]
# :clearance stays the same as cart[item][:clearance]
# :count should be adjusted so that if the cart[items][:count] > coupons[attribute][:num],
# we should check how many times coupons[attribute][:num] fits into cart[items][:count] (ruby rounds integers down by default)
# BUT then cart[attribute][:count] should deduct coupons[attribute][:num] (as many times as it fit into cart[items][:count])

def apply_coupons(cart, coupons)
    coupons.each do |attribute|
      cart.keys.each do |items|
      if attribute[:item] == items && cart[items][:count] >= attribute[:num]
        cart["#{items} W/COUPON"] = {
          price: attribute[:cost],
          clearance: cart[items][:clearance],
          count: cart[items][:count] / attribute[:num]
        }
        cart[items][:count] -= attribute[:num] * (cart[items][:count] / attribute[:num])
      end
    end
  end
  cart
end

# any item on clearance is discounted by 20%
# in our cart hash we need to iterate over the attribute_hash
# if our attribute is :clearance and if clearance is true, then the price for that item is what it was times 0.8

require "bigdecimal"

def apply_clearance(cart)
  cart.each do |items, attribute_hash|
    attribute_hash.each do |attributes, values|
      if attributes == :clearance && values == true
          cart[items][:price]*= BigDecimal("0.8")
      end
    end
  end
end

# create a checkout method that calculates the total cost of the consolidated cart.
# need to check for different scenarios. Base scenarion - there are no coupons and no clearance items.

def checkout(cart, coupons)
  total = 0
  base_cart = consolidate_cart(cart)
  cart_with_coupons = apply_coupons(base_cart, coupons)
  final_cart = apply_clearance(cart_with_coupons)
     final_cart.each do |item, attribute_hash|
       total += attribute_hash[:price] * attribute_hash[:count]
     end
        if total > 100
          total *= 0.90
        end
    total
end
