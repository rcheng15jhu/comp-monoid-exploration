import itertools
import cProfile
from typing import List, Set, Tuple, Optional


# def compose(a: Union[Tuple[int, ...], List[int]],
#             b: Union[Tuple[int, ...], List[int]]) -> Union[Tuple[int, ...], List[int]]:
#     if len(a) != len(b):
#         return None
#     # return (a[i] for i in b)
#     elif isinstance(a, list):
#         return [a[i] for i in b]
#     else:
#         return tuple(a[i] for i in b)


def compose_list(a, b) -> Optional[List[int]]:
    # if len(a) != len(b):
    #     return None
    return [a[i] for i in b]


def compose_tuple(a, b) -> Optional[Tuple[int, ...]]:
    # if len(a) != len(b):
    #     return None
    return tuple(a[i] for i in b)


# def list_valid(mlist: List[int]) -> bool:
#     list_size = len(mlist)
#     for elem in mlist:
#         if elem >= list_size or elem < 0:
#             print("{0} is an invalid list.".format(mlist))
#             return False
#     return True


# def inc_list_in_place(mlist: List[int]):
#     list_size = len(mlist)
#     mlist[-1] += 1
#     for index in reversed(range(1, list_size)):
#         if mlist[index] != list_size:
#             break
#         mlist[index] = 0
#         mlist[index - 1] += 1
#     if mlist[0] == list_size:
#         mlist[0] = 0


# def inc_list(olist: List[int]) -> List[int]:
#     list_size = len(olist)
#     nlist = olist[:]
#     nlist[-1] += 1
#     for index in reversed(range(1, list_size)):
#         if nlist[index] != list_size:
#             break
#         nlist[index] = 0
#         nlist[index - 1] += 1
#     if nlist[0] == list_size:
#         nlist[0] = 0
#     return nlist


def asc_list_valid(mlist: List[int], max_elem: int):
    list_size = len(mlist)
    for index1, elem in enumerate(mlist, 1):
        if elem > max_elem - list_size + index1 or elem + 1 < index1:
            print("asc_list_valid says {0} is an invalid list: elements aren't in the correct range.".format(mlist))
            return False
    for a, b in zip(mlist, mlist[1:]):
        if not b > a:
            print("asc_list_valid says {0} is an invalid list: elements aren't in ascending order.".format(mlist))
            return False
    return True


def inc_asc_list_in_place(mlist: List[int], max_elem: int):
    list_size = len(mlist)
    mlist[-1] += 1
    index_save = None
    for reverse_index, index in enumerate(reversed(range(1, list_size)), -1):
        if mlist[index] != max_elem - reverse_index:
            index_save = index
            break
        mlist[index - 1] += 1
    if index_save is None:
        index_save = 0
    if mlist[0] == max_elem - list_size + 2:
        mlist[0] = 0
    for index in range(index_save + 1, list_size):
        mlist[index] = mlist[index - 1] + 1


# def inc_asc_list(olist: List[int], max_elem: int) -> List[int]:
#     list_size = len(olist)
#     nlist = olist[:]
#     nlist[-1] += 1
#     index_save = None
#     for reverse_index, index in enumerate(reversed(range(1, list_size)), -1):
#         if nlist[index] != max_elem - reverse_index:
#             index_save = index
#             break
#         nlist[index - 1] += 1
#     if index_save is None:
#         index_save = 0
#     if nlist[0] == max_elem - list_size + 2:
#         nlist[0] = 0
#     for index in range(index_save + 1, list_size):
#         nlist[index] = nlist[index - 1] + 1
#     return nlist


def id_to_list(_id: int, list_size: int) -> List[int]:
    return [(_id // (list_size ** (list_size - i))) % list_size for i in range(1, list_size + 1)]


def id_to_tuple(_id: int, list_size: int) -> Tuple[int, ...]:
    return tuple((_id // (list_size ** (list_size - i))) % list_size for i in range(1, list_size + 1))


def _to_id(mlist) -> int:
    _size = len(mlist)
    return sum([elem * _size ** i for i, elem in enumerate(reversed(mlist))])


def get_ident_func(func_size: int) -> (List[int], int):
    return [i for i in range(func_size)], ((func_size ** func_size) - func_size) / ((func_size - 1) ** 2) - 1  # \
    # sum([(i - 1) * (func_size ** (func_size - i)) for i in range(1, func_size + 1)])


def get_ident_func_tuple(func_size: int) -> (Tuple[int, ...], int):
    return tuple(i for i in range(func_size)), ((func_size ** func_size) - func_size) / ((func_size - 1) ** 2) - 1  # \


def high_ord_comp_check(func, max_num: int) -> Optional[Set[Tuple[int]]]:
    ident_func = tuple(get_ident_func(len(func))[0])
    # func = tuple(func)  # perhaps not necessary if this is only called where func is already tuple
    checked_funcs = {ident_func, func}
    last_func = func
    num_last_checked = 1
    i = 0
    while num_last_checked != len(checked_funcs) and i != max_num:
        i += 1
        num_last_checked = len(checked_funcs)
        last_func = compose_tuple(func, last_func)
        checked_funcs.add(last_func)
    if num_last_checked != len(checked_funcs):
        print("Too many higher order compositions.")
        return None
    return checked_funcs.difference({ident_func})
    # return [list(func) for func in checked_funcs.difference({ident_func, tuple(func)})]


def get_start_monoid(func_size: int, monoid_size: int,
                     ident: (List[int], int) = None, max_func: int = None) -> List[int]:
    if max_func is None:
        max_func = func_size ** func_size - 1
    if monoid_size > max_func + 1:
        raise ValueError("Monoid size too large")
    if ident is None:
        ident = get_ident_func(func_size)
    current_monoid = [i for i in range(monoid_size - 1)]
    while ident[1] in current_monoid:
        inc_asc_list_in_place(current_monoid, max_func)
    return current_monoid


def naive_monoid_search(func_size: int, monoid_size: int) -> List[List[int]]:
    valid_monoids = []
    ident = get_ident_func(func_size)
    max_func = func_size ** func_size - 1
    if monoid_size > max_func + 1:
        raise ValueError("Monoid size too large")
    start_monoid = get_start_monoid(func_size, monoid_size, ident, max_func)
    current_monoid = start_monoid[:]
    while True:
        current_funcs = [id_to_list(_id, func_size) for _id in current_monoid]
        funcs_with_ident = current_funcs + [ident[0]]
        closed = True
        for func_pair in itertools.product(current_funcs, current_funcs):
            # print("{0}, {1}".format(func_pair, compose(*func_pair)))
            if compose_list(*func_pair) not in funcs_with_ident:
                closed = False
                break
        if closed:
            # print("Horray! Closed!")
            valid_monoids.append(current_monoid[:])
        while True:
            inc_asc_list_in_place(current_monoid, max_func)
            if ident[1] not in current_monoid:
                break
        if current_monoid == start_monoid:
            break
    return valid_monoids


def funcs_are_above_id(low_id: int, func_set: Set[Tuple[int, ...]], func_size) -> bool:
    return all(sum([elem * func_size ** i for i, elem in enumerate(reversed(func))]) > low_id for func in func_set)
    # The sum() function is equivalent to list_to_id, however it is unknown which way is more efficient or more pythonic


class CompComp:

    def __init__(self, func_size, monoid_size):
        self.func_size = func_size
        self.monoid_size = monoid_size
        self.valid_monoids = set()
        self.num_funcs = func_size ** func_size
        self.ident_func = get_ident_func_tuple(func_size)

    def find_all_monoids(self):
        self.finish_monoid([], 0, self.monoid_size)

    def finish_monoid(self, current_monoid, min_id, num_left):
        cur_func_id = min_id + 1 if min_id == self.ident_func[1] else 0
        while cur_func_id < self.num_funcs - num_left:
            higher_order_comps = high_ord_comp_check(id_to_tuple(cur_func_id, self.func_size), num_left)
            print(higher_order_comps)
            cur_func_id += 2 if cur_func_id + 1 == self.ident_func[1] else 1

if __name__ == '__main__':
    print("Hi!")
    # print(len(naive_monoid_search(2, 3)))
    # print(len(naive_monoid_search(3, 3)))
    # cProfile.run("print(len(naive_monoid_search(3, 6)))")
    # cProfile.run("print(len(naive_monoid_search(4, 3)))")
    # cProfile.run("print(len(naive_monoid_search(5, 3)))")
    # comp_monoid_search(3, 3)
    test = CompComp(3, 3)
    test.find_all_monoids()


# def trashed_comp_monoid_search(func_size: int, monoid_size: int) -> List[List[int]]:
#     valid_monoids = []
#     ident = get_ident_func(func_size)
#     max_func = func_size ** func_size - 1  # inclusive 0-based
#     if monoid_size > max_func + 1:
#         raise ValueError("Monoid size too large")
#     all_valid_ids = [i for i in range(max_func + 1)]
#     all_valid_ids.remove(ident[1])
#
#     # def get_next_func_fam_id():  # This is probably un-pythonic, but...
#     #     get_next_func_fam_id.counter = getattr(get_next_func_fam_id, "counter", -1) + 1
#     #     return get_next_func_fam_id.counter
#
#     for low_index, low_id in enumerate(all_valid_ids[:1 - monoid_size]):
#         current_monoid = set()
#         current_high_ord_comps = []
#         gen_next_func_comps = (func_high_ord_comps for _id in all_valid_ids[low_index:]
#                                if (func_high_ord_comps := high_ord_comp_check(id_to_list(_id, func_size),
#                                                                               monoid_size - len(current_monoid)))
#                                is not None and funcs_are_above_id(low_id, func_high_ord_comps, func_size))
#         while len(current_monoid) < monoid_size:
#             current_monoid.add(gen_next_func_comps.__next__())
#             print(current_monoid)
