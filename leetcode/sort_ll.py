#Definition for singly-linked list.
class ListNode(object):
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next
class Solution(object):
    def mergeTwoLists(self, list1, list2):
        itr1 = list1
        itr2 = list2
        ans = ListNode(0)
        head = ans
        while itr1 is not None:
            if itr2 is None:
                ans.next = itr1
                break
            elif itr1.val < itr2.val:
                ans.next = itr1
                ans = ans.next
                itr1 = itr1.next
            else:
                ans.next = itr2
                ans = ans.next
                itr2 = itr2.next
            print(ans)
        if itr2 is not None:
            ans.next = itr2
        print(head)
        return head.next
            
    




