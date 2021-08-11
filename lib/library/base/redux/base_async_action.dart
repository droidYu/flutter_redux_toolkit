class BaseFulfilledAction<Data> {
  Data data;
  BaseFulfilledAction(this.data);
}

class BasePendingAction {
  bool isLoading = true;
  BasePendingAction({isLoading = true}) {
    this.isLoading = isLoading;
  }
}

class BaseRejectedAction {
  Exception ex;
  BaseRejectedAction(this.ex);
}
