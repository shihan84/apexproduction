<?php

namespace Modules\Shorts\Http\Controllers\Backend;

use App\Http\Controllers\Controller;
use Modules\Shorts\Models\ShortCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ShortCategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories = ShortCategory::with(['user'])
            ->latest()
            ->paginate(20);

        return view('shorts::backend.categories.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('shorts::backend.categories.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'boolean',
        ]);

        $validated['user_id'] = auth()->id();
        $validated['slug'] = Str::slug($validated['name']);

        ShortCategory::create($validated);

        return redirect()
            ->route('backend.shorts.categories.index')
            ->with('success', 'Category created successfully.');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ShortCategory $category)
    {
        return view('shorts::backend.categories.edit', compact('category'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ShortCategory $category)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'boolean',
        ]);

        $validated['slug'] = Str::slug($validated['name']);

        $category->update($validated);

        return redirect()
            ->route('backend.shorts.categories.index')
            ->with('success', 'Category updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ShortCategory $category)
    {
        $category->delete();

        return redirect()
            ->route('backend.shorts.categories.index')
            ->with('success', 'Category deleted successfully.');
    }
}
