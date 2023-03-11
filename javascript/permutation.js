  // Function to swap variables' content.
  function swap(index1, index2) {
    tmp = arr[index1];
    arr[index1] = arr[index2];
    arr[index2] = tmp;
  }


function generate(int) {
  if (int === 1) {
    // Make sure to join the characters as we create  the permutation arrays
    permutations.push(arr.join(""));
    console.table(int,...arr,...permutations);
  } else {
    for (let i = 0; i != int; ++i) {
      console.table(int,i,...arr,...permutations);
      generate(int - 1);
      swap(int % 2 ? 0 : i, int - 1);
    }
  }
}

arr = [...'xyz']
permutations=[]
generate(3)

// 3 0 'x' 'y' 'z'
// 2 0 'x' 'y' 'z'
// 1   'x' 'y' 'z' 'xyz'
// 2 1 'y' 'x' 'z' 'xyz'
// 1   'y' 'x' 'z' 'xyz' 'yxz'
// 3 1 'z' 'x' 'y' 'xyz' 'yxz'
// 2 0 'z' 'x' 'y' 'xyz' 'yxz'
// 1   'z' 'x' 'y' 'xyz' 'yxz' 'zxy'
// 2 1 'x' 'z' 'y' 'xyz' 'yxz' 'zxy'
// 1   'x' 'z' 'y' 'xyz' 'yxz' 'zxy' 'xzy'
// 3 2 'y' 'z' 'x' 'xyz' 'yxz' 'zxy' 'xzy'
// 2 0 'y' 'z' 'x' 'xyz' 'yxz' 'zxy' 'xzy'
// 1   'y' 'z' 'x' 'xyz' 'yxz' 'zxy' 'xzy' 'yzx'
// 2 1 'z' 'y' 'x' 'xyz' 'yxz' 'zxy' 'xzy' 'yzx'
// 1   'z' 'y' 'x' 'xyz' 'yxz' 'zxy' 'xzy' 'yzx' 'zyx'

arr = [...'abcd']
permutations=[]
generate(arr.length)

4 0 'a' 'b' 'c' 'd'
3 0 'a' 'b' 'c' 'd'
2 0 'a' 'b' 'c' 'd'
1 'a' 'b' 'c' 'd' 'abcd'
2 1 'b' 'a' 'c' 'd' 'abcd'
1 'b' 'a' 'c' 'd' 'abcd' 'bacd'
3 1 'c' 'a' 'b' 'd' 'abcd' 'bacd'
2 0 'c' 'a' 'b' 'd' 'abcd' 'bacd'
1 'c' 'a' 'b' 'd' 'abcd' 'bacd' 'cabd'
2 1 'a' 'c' 'b' 'd' 'abcd' 'bacd' 'cabd'
1 'a' 'c' 'b' 'd' 'abcd' 'bacd' 'cabd' 'acbd'
3 2 'b' 'c' 'a' 'd' 'abcd' 'bacd' 'cabd' 'acbd'
2 0 'b' 'c' 'a' 'd' 'abcd' 'bacd' 'cabd' 'acbd'
1 'b' 'c' 'a' 'd' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad'
2 1 'c' 'b' 'a' 'd' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad'
1 'c' 'b' 'a' 'd' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad'
4 1 'd' 'b' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad'
3 0 'd' 'b' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad'
2 0 'd' 'b' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad'
1 'd' 'b' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca'
2 1 'b' 'd' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca'
1 'b' 'd' 'c' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca'
3 1 'c' 'd' 'b' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca'
2 0 'c' 'd' 'b' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca'
1 'c' 'd' 'b' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba'
2 1 'd' 'c' 'b' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba'
1 'd' 'c' 'b' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba'
3 2 'b' 'c' 'd' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba'
2 0 'b' 'c' 'd' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba'
1 'b' 'c' 'd' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda'
2 1 'c' 'b' 'd' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda'
1 'c' 'b' 'd' 'a' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda'
4 2 'd' 'a' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda'
3 0 'd' 'a' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda'
2 0 'd' 'a' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda'
1 'd' 'a' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb'
2 1 'a' 'd' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb'
1 'a' 'd' 'c' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb'
3 1 'c' 'd' 'a' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb'
2 0 'c' 'd' 'a' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb'
1 'c' 'd' 'a' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab'
2 1 'd' 'c' 'a' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab'
1 'd' 'c' 'a' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab'
3 2 'a' 'c' 'd' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab'
2 0 'a' 'c' 'd' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab'
1 'a' 'c' 'd' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb'
2 1 'c' 'a' 'd' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb'
1 'c' 'a' 'd' 'b' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb'
4 3 'd' 'a' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb'
3 0 'd' 'a' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb'
2 0 'd' 'a' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb'
1 'd' 'a' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc'
2 1 'a' 'd' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc'
1 'a' 'd' 'b' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc'
3 1 'b' 'd' 'a' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc'
2 0 'b' 'd' 'a' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc'
1 'b' 'd' 'a' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac'
2 1 'd' 'b' 'a' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac'
1 'd' 'b' 'a' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac'
3 2 'a' 'b' 'd' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac'
2 0 'a' 'b' 'd' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac'
1 'a' 'b' 'd' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac' 'abdc'
2 1 'b' 'a' 'd' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac' 'abdc'
1 'b' 'a' 'd' 'c' 'abcd' 'bacd' 'cabd' 'acbd' 'bcad' 'cbad' 'dbca' 'bdca' 'cdba' 'dcba' 'bcda' 'cbda' 'dacb' 'adcb' 'cdab' 'dcab' 'acdb' 'cadb' 'dabc' 'adbc' 'bdac' 'dbac' 'abdc' 'badc'



