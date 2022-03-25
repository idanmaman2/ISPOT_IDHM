import 'dart:math';

extension Shuffling<T> on Set<T> {
  List<T> shuffle() {
    List<T> fromSet = toList();
    Random rnd = Random ();
    for(int i =0 ; i<fromSet.length ; i++)
    {
      int index =rnd.nextInt(fromSet.length);
      T tmp = fromSet[i];
      fromSet[i] = fromSet[index];
      fromSet[index] = tmp ;
    }
    return fromSet;
  }

}