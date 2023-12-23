import 'package:flutter/material.dart';
import 'package:piix_mobile/utils/shimmer/shimmer.dart';

///This widget is the one in charge of painting and generating the gradient
/// effect in each element
///
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.child,
    this.isLoading = false,
  });

  final Widget child;
  final bool isLoading;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // when the widget is rendering add listener to watch the changes an init
      //the animation.
      _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
      _shimmerChanges?.addListener(_onShimmerChange);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_shimmerChanges == null) return;
    // when the widget is removing of the tree remove listener
    _shimmerChanges!.removeListener(_onShimmerChange);
  }

  //this method used for update the shimmer painting.
  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {});
      return;
    }
    setState(() {
      _crossFadeState = CrossFadeState.showSecond;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Collect ancestor shimmer info.
    final shimmer = Shimmer.of(context)!;
    return AnimatedCrossFade(
      firstChild: ShimmerLoadingFirstChild(widget.child, shimmer: shimmer),
      secondChild: widget.child,
      crossFadeState: _crossFadeState,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class ShimmerLoadingFirstChild extends StatelessWidget {
  const ShimmerLoadingFirstChild(
    this.child, {
    super.key,
    required this.shimmer,
  });

  final ShimmerState shimmer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget has not laid
      // itself out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: child,
    );
  }
}
