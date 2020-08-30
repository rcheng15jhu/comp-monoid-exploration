import itertools
import cProfile
from typing import List, Union


def compose(a: List[int], b: List[int]):
    if len(a) != len(b):
        return []
    else:
        return [a[i] for i in b]


def list_valid(mlist: List[int]) -> bool:
    list_size = len(mlist)
    for elem in mlist:
        if elem >= list_size or elem < 0:
            print("{0} is an invalid list.".format(mlist))
            return False
    return True


def inc_list_in_place(mlist: List[int]):
    list_size = len(mlist)
    mlist[-1] += 1
    for index in reversed(range(1, list_size)):
        if mlist[index] != list_size:
            break
        mlist[index] = 0
        mlist[index - 1] += 1
    if mlist[0] == list_size:
        mlist[0] = 0


def inc_list(olist: List[int]) -> List[int]:
    list_size = len(olist)
    nlist = olist[:]
    nlist[-1] += 1
    for index in reversed(range(1, list_size)):
        if nlist[index] != list_size:
            break
        nlist[index] = 0
        nlist[index - 1] += 1
    if nlist[0] == list_size:
        nlist[0] = 0
    return nlist


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


def inc_asc_list(olist: List[int], max_elem: int) -> List[int]:
    list_size = len(olist)
    nlist = olist[:]
    nlist[-1] += 1
    index_save = None
    for reverse_index, index in enumerate(reversed(range(1, list_size)), -1):
        if nlist[index] != max_elem - reverse_index:
            index_save = index
            break
        nlist[index - 1] += 1
    if index_save is None:
        index_save = 0
    if nlist[0] == max_elem - list_size + 2:
        nlist[0] = 0
    for index in range(index_save + 1, list_size):
        nlist[index] = nlist[index - 1] + 1
    return nlist


def id_to_list(_id: int, list_size: int) -> List[int]:
    return [(_id // (list_size ** (list_size - i))) % list_size for i in range(1, list_size + 1)]


def list_to_id(mlist: List[int]) -> int:
    list_size = len(mlist)
    return sum([elem * list_size ** i for i, elem in enumerate(reversed(mlist))])


def get_ident_func(func_size: int) -> (List[int], int):
    return [i for i in range(func_size)], ((func_size ** func_size) - func_size) / ((func_size - 1) ** 2) - 1  # \
    # sum([(i - 1) * (func_size ** (func_size - i)) for i in range(1, func_size + 1)])


def high_ord_comp_check(func: List[int], max_num: int) -> Union[None, List[List[int]]]:
    ident_func = tuple(get_ident_func(len(func))[0])
    checked_funcs = {ident_func, tuple(func)}
    last_func = func
    num_last_checked = 0
    i = -1
    while num_last_checked != len(checked_funcs) and i != max_num:
        i += 1
        num_last_checked = len(checked_funcs)
        last_func = compose(func, last_func)
        checked_funcs.add(tuple(last_func))
    if num_last_checked != len(checked_funcs):
        print("Too many higher order compositions.")
        return None
    return [list(func) for func in checked_funcs.difference({ident_func, tuple(func)})]


def get_start_monoid(func_size: int, monoid_size: int, ident: (List[int], int) = None, max_func: int = None) -> List[
    int]:
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
            if compose(*func_pair) not in funcs_with_ident:
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




def comp_monoid_search(func_size: int, monoid_size: int) -> List[List[int]]:
    valid_monoids = []
    ident = get_ident_func(func_size)
    max_func = func_size ** func_size - 1  # inclusive 0-based
    if monoid_size > max_func + 1:
        raise ValueError("Monoid size too large")
    all_valid_ids = [i for i in range(max_func + 1)]
    all_valid_ids.remove(ident[1])
    current_monoid = []

    def get_next_func_fam_id():  # This is probably un-pythonic, but...
        get_next_func_fam_id.counter = getattr(get_next_func_fam_id, "counter", 0) + 1
        return get_next_func_fam_id.counter

    for low_index, low_id in enumerate(all_valid_ids[:1-monoid_size]):
        gen_next_func_obs = ((id_to_list(_id, func_size), get_next_func_fam_id()) for _id in all_valid_ids[low_index:])
        while len(current_monoid) < monoid_size:
            current_monoid.append(gen_next_func_obs.__next__())
            print(current_monoid)
        current_monoid = []
        del get_next_func_fam_id.counter


if __name__ == '__main__':
    print("Hi!")
    # print(len(naive_monoid_search(2, 3)))
    # print(len(naive_monoid_search(3, 3)))
    # cProfile.run("print(len(naive_monoid_search(3, 6)))")
    # cProfile.run("print(len(naive_monoid_search(4, 3)))")
    # cProfile.run("print(len(naive_monoid_search(5, 3)))")
    comp_monoid_search(3, 3)
