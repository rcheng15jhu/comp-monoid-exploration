from unittest import TestCase
import helper_functions as hf


class Test(TestCase):

    def test_compose_list(self):
        self.assertEqual(hf.compose_list([0, 1, 2], [2, 1, 0]), [2, 1, 0])
        self.assertEqual(hf.compose_list([1, 2, 0], [2, 0, 1]), [0, 1, 2])
        self.assertEqual(hf.compose_list([0, 2, 2], [0, 1, 1]), [0, 2, 2])
        self.assertEqual(hf.compose_list([0, 1, 1], [0, 2, 2]), [0, 1, 1])

    # def test_inc_list_in_place(self):
    #     mlist = [2, 2, 2]
    #     hf.inc_list_in_place(mlist)
    #     self.assertEqual(mlist, [0, 0, 0])
    #     mlist = [1, 2, 2]
    #     hf.inc_list_in_place(mlist)
    #     self.assertEqual(mlist, [2, 0, 0])
    #     mlist = [1, 1, 2]
    #     hf.inc_list_in_place(mlist)
    #     self.assertEqual(mlist, [1, 2, 0])
    #
    #     self.assertFalse(hf.list_valid([1, 2, 3]))
    #
    # def test_inc_list(self):
    #     self.assertEqual(hf.inc_list([2, 2, 2]), [0, 0, 0])

    def test_inc_asc_list_in_place(self):
        temp = [[0, 1, 2, 3]]
        while True:
            # temp.append(hf.inc_asc_list(temp[-1], 4))
            temp.append(temp[-1][:])
            hf.inc_asc_list_in_place(temp[-1], 4)
            if temp[0] == temp[-1]:
                break

        self.assertEqual(temp, [[0, 1, 2, 3], [0, 1, 2, 4], [0, 1, 3, 4], [0, 2, 3, 4], [1, 2, 3, 4], [0, 1, 2, 3]])

        self.assertFalse(hf.asc_list_valid([1, 2, 4], 3))
        self.assertFalse(hf.asc_list_valid([-1, 0, 1], 3))
        self.assertFalse(hf.asc_list_valid([2, 2, 2], 4))

    def test_id_to_list(self):
        self.assertEqual(hf.id_to_list(2, 3), [0, 0, 2])
        self.assertEqual(hf.id_to_list(2, 2), [1, 0])

    def test__to_id(self):
        self.assertEqual(hf._to_id(hf.id_to_list(23, 3)), 23)
        self.assertEqual(hf._to_id(hf.id_to_list(27, 3)), 0)

    def test_get_ident_func(self):
        self.assertEqual(hf.get_ident_func(3), ([0, 1, 2], 5))
        self.assertEqual((hf._to_id(hf.get_ident_func(3)[0]), hf.id_to_list(hf.get_ident_func(3)[1], 3)),
                         (5, [0, 1, 2]))

    def test_high_ord_comp_check(self):
        self.assertEqual(hf.high_ord_comp_check((1, 2, 3, 4, 4), 4),
                         {(1, 2, 3, 4, 4), (2, 3, 4, 4, 4), (3, 4, 4, 4, 4), (4, 4, 4, 4, 4)})
        self.assertEqual(hf.high_ord_comp_check((1, 2, 3, 3), 3),
                         {(1, 2, 3, 3), (2, 3, 3, 3), (3, 3, 3, 3)})
        self.assertEqual(hf.high_ord_comp_check((1, 2, 0), 2),
                         {(1, 2, 0), (2, 0, 1)})
        self.assertEqual(hf.high_ord_comp_check((0, 0, 2), 1),
                         {(0, 0, 2)})
        self.assertEqual(hf.high_ord_comp_check((1, 0, 2), 1),
                         {(1, 0, 2)})
        self.assertEqual(hf.high_ord_comp_check((1, 2, 0, 4, 3), 5),
                         {(0, 1, 2, 4, 3), (1, 2, 0, 3, 4), (1, 2, 0, 4, 3), (2, 0, 1, 3, 4), (2, 0, 1, 4, 3)})
        self.assertEqual(hf.high_ord_comp_check((1, 2, 3, 0, 4), 3),
                         {(1, 2, 3, 0, 4), (2, 3, 0, 1, 4), (3, 0, 1, 2, 4)})

        self.assertEqual(hf.high_ord_comp_check((1, 2, 3, 4, 4), 3), None)

    def test_funcs_are_above_id(self):
        self.assertTrue(hf.funcs_are_above_id(0, {(0, 0, 1), (0, 0, 2)}, 3))
        self.assertFalse(hf.funcs_are_above_id(0, {(0, 0, 0), (0, 0, 2)}, 3))