// Merge sort implementation
import 'components/expense.dart';

List<ExpenseItem> mergeSort(List<ExpenseItem> list) {
  if (list.length <= 1) {
    return list;
  }

  final mid = list.length ~/ 2;
  final leftList = list.sublist(0, mid);
  final rightList = list.sublist(mid);

  return merge(mergeSort(leftList), mergeSort(rightList));
}

List<ExpenseItem> merge(List<ExpenseItem> leftList, List<ExpenseItem> rightList) {
  final mergedList = <ExpenseItem>[];
  var leftIndex = 0;
  var rightIndex = 0;

  while (leftIndex < leftList.length && rightIndex < rightList.length) {
    if (leftList[leftIndex].dateTime.isAfter(rightList[rightIndex].dateTime)) {
      mergedList.add(leftList[leftIndex]);
      leftIndex++;
    } else {
      mergedList.add(rightList[rightIndex]);
      rightIndex++;
    }
  }

  while (leftIndex < leftList.length) {
    mergedList.add(leftList[leftIndex]);
    leftIndex++;
  }

  while (rightIndex < rightList.length) {
    mergedList.add(rightList[rightIndex]);
    rightIndex++;
  }

  return mergedList;
}
