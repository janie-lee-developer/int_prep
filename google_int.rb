# runtime 147ms
# memory usage 210.2mb

#Every valid email consists of a local name and a domain name, separated by the '@' sign. Besides lowercase letters, the email may contain one or more '.' or '+'.

#For example, in "alice@leetcode.com", "alice" is the local name, and "leetcode.com" is the domain name.
#If you add periods '.' between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name. Note that this rule does not apply to domain names.

#For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.
#If you add a plus '+' in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered. Note that this rule does not apply to domain names.

#For example, "m.y+name@email.com" will be forwarded to "my@email.com".
#It is possible to use both of these rules at the same time.

#Given an array of strings emails where we send one email to each email[i], return the number of different addresses that actually receive mails.

#Input: emails = ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
#Output: 2
#Explanation: "testemail@leetcode.com" and "testemail@lee.tcode.com" actually receive mails.

#Input: emails = ["a@leetcode.com","b@leetcode.com","c@leetcode.com"]
#Output: 3

# @param {String[]} emails
# @return {Integer}
# def num_unique_emails(emails)
#     # split email by @, 
#     # If local has a dot, remove the dot, if + cut the email after. save in the hash
#     # Add it with domain
#     # save in hash
#     hash = Hash.new(0)
#     emails.each do |email|
#         splitted = email.split("@")
#         new_str = ""
#         splitted[0].each_char do |char|
#             if char != "." && char != "+"
#                 new_str << char
#             elsif char == "+"
#                 break
#             end
#         end
#         splitted[0] = new_str
#         new_email = splitted.join("@")
#         hash[new_email] += 1
#     end
#     hash.keys.length
# end


# @param {String[]} emails
# @return {Integer}
def num_unique_emails(emails)
    # split email by @, 
    # If local has a dot, remove the dot, if + cut the email after. save in the hash
    # Add it with domain
    # save in hash
    hash = Hash.new(0)
    
    emails.each do |email|
        new_str = ""
        email.each_char do |char|
            if char != '.' && char != '+'
                new_str << char
            elsif char == "+"
                break
            elsif char == "@"
                break
            end
        end
        domain = ""
        email.reverse.each_char do |char|
            if char != "@"
                domain << char
            elsif char == "@"
                domain << char
                break
            end
        end
        p new_str + domain.reverse
    end
    
    hash.keys
end

p num_unique_emails(["test.email+alex@leetcode.com", "test.email@leetcode.com"])


#98ms
def num_unique_emails(emails)
    emails.map{|email| 
        split = email.split('@')
        email = split[0].gsub('.', '').split('+')[0] + '@' + split[1]
        }.uniq.count
    
end

#vs

#68ms
#memory 210.mb
def num_unique_emails(emails)
    emails.map do |mail|
        at_index = mail.index('@')
        tail = mail[at_index..-1]
        head = mail[0...at_index].gsub(".","")
        plus_index = head.index('+')
        plus_index != nil ? head[0...plus_index]+tail : head+tail 
    end.uniq.length
end